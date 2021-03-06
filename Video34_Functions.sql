-- USER DEFINED FUNCTIONS (UDF)
-------------------------------

USE CURSO_SQL2014_IMPL
GO

-- FUNCTIONS ARE VERY SIMILAR TO STORED PROCEDURES: THEY CAN CONTAIN T-SQL CODE
-- THE PARAMETERS OPTIONS ARE SIMILAR TO STORED PROCEDURES
-- YOU HAVE TO USE PARENTHESIS ( AND ) WHEN CALLING FUNCTIONS
-- FUNCTIONS HAVE TO RETURN SOME VALUE (OR A TABLE LIKE RESULT SET)

-- YOU CAN USE FUNCTIONS TO DEVELOP SIMPLE BUSINESS LOGIC, DATA TRANSFORMATION AND OTHER
-- TRY TO BALANCE WHAT YOU DO ON THE APPLICATION 
-- AND ON THE DATABASE SERVER WITH FUNCTIONS AND STORED PROCEDURES

-- THERE ARE THREE TYPES OF FUNCIONS IN SQL SERVER:
	--> SCALAR: RETURN JUST ONE VALUE (ONE COLUMN AND ONE ROW)
	--> INLINE TABLE-VALUED: CONTAIN JUST ONE SELECT STATEMENT AND RETURN A RESULTSET
	--> MULTI-STATEMENT TABLE-VALUED: CONTAIN MANY COMMANDS AND RETURN A RESULTSET

-- WHEN YOU CREATE A FUNCTION YOU HAVE TO SPECIFY THE RETURN TYPE

-- NOTE: THERE ARE SOME LIMITATIONS ABOUT THE CONTENT OF A FUNCION. CHECK THE DOCUMENTATION
-- NOTE: ALWAYS CALL A FUNCTION WITH ITS SCHEMMA

-- EXAMPLES:

-- SCALAR FUNCTION
------------------

CREATE FUNCTION ALLTRIM(@STR_ENTRADA VARCHAR(200))
RETURNS VARCHAR(200)
AS
BEGIN
	RETURN RTRIM(LTRIM(@STR_ENTRADA))
END

SELECT NOMECLIENTE
      ,dbo.ALLTRIM(NomeCliente)
	  ,dbo.ALLTRIM(' A')
FROM CLIENTES


-- INLINE TABLE-VALUED
----------------------

CREATE FUNCTION  GET_TAB()
RETURNS TABLE
AS
RETURN ( SELECT IdCliente, Nomecliente FROM CLIENTES
		 WHERE Nomecliente LIKE '%a')
GO

SELECT * FROM dbo.GET_TAB()

-- NOTE: MAYBE YOU SHOULD CONSIDER USING A VIEW INSTEAD OF A INLINE TABLE-VALUED?

-- MULTI-STATEMENT TABLE-VALUED
-------------------------------

CREATE TABLE TAB_RET
(
	ID INT,
	NAME VARCHAR(100)
)
GO


CREATE FUNCTION F_INSERT ( @ID INT )
RETURNS @TAB_RET TABLE ( ID INT , NAME VARCHAR(20) )
AS
BEGIN
	INSERT INTO @TAB_RET VALUES(@ID,'TEST')

	RETURN
END

SELECT * FROM dbo.F_INSERT(10)

