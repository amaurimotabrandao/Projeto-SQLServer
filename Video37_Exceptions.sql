-- ERROS AND EXCEPTIONS
-----------------------------------------

USE CURSO_SQL2014_IMPL
GO

-- EXCEPTIONS ARE A MECHANISM TO HANDLE ERROS AND UNPREPARED SCENARIOS




-- 1) TRADICIONAL ERROR HANDLING WITH @@ERROR

------------------------------------------------------
-- SYNTAX AND STRUCTURE:
------------------------------------------------------

-- DO SOME PROCESSING
IF @@ERROR <> 0
BEGIN
	-- DO ROLLBACK TO CANCEL THINGS
END
ELSE
BEGIN
	-- COMMIT AND FINALIZE THE CODE
END


------------------------------------------------------
-- EXAMPLE:
------------------------------------------------------
-- Drop the procedure if it already exists.
IF OBJECT_ID(N'HumanResources.usp_DeleteCandidate', N'P') IS NOT NULL
    DROP PROCEDURE HumanResources.usp_DeleteCandidate;
GO
-- Create the procedure.
CREATE PROCEDURE HumanResources.usp_DeleteCandidate 
    (
    @CandidateID INT
    )
AS
-- Execute the DELETE statement.
DELETE FROM HumanResources.JobCandidate
    WHERE JobCandidateID = @CandidateID;

-- Test the error value.
IF @@ERROR <> 0 
    BEGIN
        -- Return 99 to the calling program to indicate failure.
        PRINT N'An error occurred deleting the candidate information.';
        RETURN 99;
    END
ELSE
    BEGIN
        -- Return 0 to the calling program to indicate success.
        PRINT N'The job candidate has been deleted.';
        RETURN 0;
    END;
GO



-- 2) USING EXCEPTIONS

-- CONCEPT OF PROTECTED CODE

------------------------------------------------------
-- SYNTAX:
------------------------------------------------------

BEGIN TRY
	-- HERE COMES THE PROTECTED CODE
END TRY

BEGIN CATCH
	-- HERE COMES THE EXCEPTION HANDLING
END CATCH

------------------------------------------------------
-- EXAMPLE:
------------------------------------------------------

BEGIN TRY
	RAISERROR ('SOMETHING IS A MISS',16,1)
	-- select getdate()
END TRY

SELECT MONTH(GETDATE())

BEGIN CATCH
		
	SELECT ERROR_NUMBER() AS ERRORNUMBER
	     , ERROR_SEVERITY() AS ERRORSEVERITY
	     , ERROR_STATE() AS ERRORSTATE
		 , ERROR_LINE() AS ERRORLINE
	     , CAST(ERROR_PROCEDURE() AS VARCHAR(30)) AS ERRORPROCEDURE
		 , CAST(ERROR_MESSAGE() AS VARCHAR(40))AS ERRORMESSAGE

END CATCH

SELECT * FROM produts


-- TIPS: 
-- A) WHEN USING TRANSACTIONS, CHECK THE STATE OF  XACT_STATE(). EXAMPLE:

BEGIN TRY
    BEGIN TRANSACTION;

    -- A FOREIGN KEY constraint exists on this table. This 
    -- statement will generate a constraint violation error.
    DELETE FROM Production.Product
        WHERE ProductID = 980;

    -- If the delete operation succeeds, commit the transaction.
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH

    -- Roll back any active or uncommittable transactions before
    -- inserting information in the ErrorLog.
    IF XACT_STATE() <> 0
    BEGIN
        ROLLBACK TRANSACTION;
    END

END CATCH; 

-- B) IF YOU HAVE TO HANDLE MANY EXCEPTIONS, CREATE A STORED
-- PROCEDURE TO AVOID CONDITIONALS INSIDE BEGIN CATCH...END CATCH

-- C) IF POSSIBLE, LOG THE ERROR FOR FURTHER DEBBUG IN A GLOBAL TABLE

-- D) NEVER FORGET TO SEND A MESSAGE TO THE USER (VIA APPLICATION)
-- EXPLAINING WHAT HAPPENED

-- E) TRY TO AVOID NESTED TRY/CATCH BLOCKS INSIDE A SAME PROCEDURE