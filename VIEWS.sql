/*INNER JOINS PADR�O N�O ANSI*/
SELECT 
	A.IDTRANSPORTADORA,
	C.NOMETRANSPORTADORA
FROM PEDIDOS AS A,
	(SELECT IDPEDIDO FROM ITENS_PEDIDO WHERE QTDEPEDIDO <=5) AND	
	TRANSPORTADORA C
WHERE	
	A.IDTRANSPORTADORA = B.IDPEDIDO AND
	A.IDPEDIDO = B.IDPEDIDO
ORDER BY
	A.IDTRANSPORTADORA

/*CRIANDO UMA VIEW*/
CREATE VIEW TESTE AS
SELECT * FROM FILME
-- UMA VIEW N�O PODE SE ALTO REFERENCIAR E N�O PODE TER ORDER BY
-- PARA UTILIZAR ORDER BY TEM USAR TOP 100 %

/*MOSTRA O CONTEUDO DA VIEW*/
SP_HELPTEXT TESTE
ALTER TABLE MIDIA DROP CONSTRAINT FK__MIDIA__COD_FILME__276EDEB3

SP_HELP FILME

EXEC sp_fkeys FILME
EXEC sp_foreign_keys_rowset2 FILME
EXEC sp_foreign_keys_rowset FILME

