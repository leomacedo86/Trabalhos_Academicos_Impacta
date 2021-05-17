

--01. Liste os pedidos entregues para a cidade de Resende, Brasil.
use TSQL2012
SELECT * FROM  SALES.ORDERS

WHERE shipcountry = 'BRAZIL' AND shipcity = 'Resende' 
ORDER BY orderid

--02. Encontre os pedidos entregues para as capitais dos estados brasileiros.

SELECT	orderid,
		shipcity,
		shipregion,
		shipcountry

FROM 	SALES.ORDERS
	
WHERE shipcountry = 'BRAZIL' AND shipcity IN ('Sao Paulo','Rio de Janeiro')
ORDER BY orderid


--03. Traga somente a quantidade de pedidos realizados para entrega na região SUDESTE do Brasil.

SELECT COUNT(orderid) as soma_pedidos

FROM 	SALES.ORDERS
WHERE shipcountry = 'BRAZIL' AND shipregion IN ('SP','RJ')

--04. Adicione a query anterior a soma dos valores dos fretes, o menor e maior frete pago e a
--média do valor de frete.

SELECT	COUNT (orderid)	as soma_pedidos,
		SUM (freight)	as soma_dos_fretes,
		MIN (freight)	as menor_frete,
		MAX (freight)	as maior_frete,
		AVG (freight)	as media_frete

FROM	SALES.ORDERS
WHERE shipcountry = 'BRAZIL' AND shipregion IN ('SP','RJ')

--05.Traga apenas a soma dos preços dos itens de produtos entregues para o país Brasil ?

SELECT	SUM (det.unitprice)	as soma_valor_products

FROM	Sales.Orders		as ord
INNER JOIN
		Sales.OrderDetails	as det
ON		ord.orderid			= det.orderid
WHERE	shipcountry = 'BRAZIL'

--13.Liste os número de pedidos onde ao menos um dos produtos comprados tenha sido fornecido por
--Singapura.


SELECT
		ord.orderid			,
		prodt.productname	,
		sup.companyname		,
		cat.description		,
		det.unitprice		,
		sup.city			,
		sup.country			,
		sup.region			
												
FROM	Sales.Orders			as	ord
INNER JOIN
		Sales.OrderDetails		as	det
ON		
		ord.orderid				=	det.orderid
INNER JOIN
		Production.Products		as	prodt
ON	
		prodt.productid			=	det.productid
INNER JOIN
		Production.Suppliers	as	sup
ON
		prodt.supplierid		=	sup.supplierid
INNER JOIN
		Production.Categories	as	cat
ON		cat.categoryid			=	prodt.categoryid

order by orderid




