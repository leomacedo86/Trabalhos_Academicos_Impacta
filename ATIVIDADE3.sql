-- 1 - Retornar os apelidos número do pedido (orderid), data do pedido (orderdate), nome do contato (contactname) e o país (country).

-- 2 Retornar os apelidos data do pedido (orderdate), nome do contato (contactname), nome completodo empregado (firstname/lastname) e país do empregado (country), onde o país do empregadoseja Inglaterra.

-- 3 Retornar os apelidos número do pedido (orderid), data do pedido (orderdate), nome do contato do cliente (contactname), nome completo do empregado (firstname/lastname) e país do cliente (country), onde o país do cliente seja Brasil, ordernado pela data do pedido mais recente.

-- 4 Retornar os apelidos número do pedido (orderid), data do pedido (orderdate), nome do contato(contactname), nome completo do empregado (firstname/lastname), país do empregado (country)e nome da empresa de entrega, onde o país do empregado seja Estados Unidos e a empresa de entrega seja Shipper ETYNR ou Shipper GVSUA. Ordene pelo número do pedido 

-- 5 Retorne todas informações de nome do produto e o nome da categoria, onde esta seja Beverages e o preço do produto (unitprice) seja menor que 30, ordenado pelo preço de forma descendente.

-- 6 Retorne os apelidos, nome do produto (productname), nome da empresa de entrega (companyname) e a quantidade do produto (qty), quando essa ultrapassar 100 unidades. Ordene -- pelo nome do produto ascendente e quantidade de forma descendente.

 -- 7 Retorne os apelidos, nome do contato do cliente (contactname), nome do produto (productname), quantidade do produto (qty), data do pedido (orderdate) e cidade do fornecedor (city), onde a data do pedido seja todo o mês de julho de 2006, a quantidade de produtos seja maior ou igual a 20 e menor que 60, o nome do produto inicie por Product A ou Product G, o nome da cidade do fornecedor seja Stockholm, Sydney, Sandvika ou Ravenna. Ordene pelo número do empregado (empid) de forma descendente 
 
 ------------------------------------------------------------------------------------------------
--EXERCÍCIO 01

Select
		ord.orderid										--número pedido (Orders)
	,	ord.orderdate									--data pedido (Orders)
	,	cust.contactname								--nome do contrato (Customers)
	,	cust.country									--país (Customers)
from
	  Sales.Orders as ord
inner join
	 Sales.Customers as cust
on
	  ord.custid = cust.custid

--EXERCÍCIO 02

Select 
			ord.orderdate							--data pedido (Orders)
		,	cust.contactname						--nome do contato (Customers)
		,	empl.firstname							--primeiro nome (Employees)
		,	empl.lastname							--segundo nome (Employees)
		,	empl.country							--país (sem restrição) (Employees)
		 	
From 
	Sales.Orders as ord
inner join
	Sales.Customers as cust
on
	ord.custid = cust.custid

inner join
	HR.Employees as empl
on	
	ord.empid = empl.empid

where empl.country = 'Inglaterra'							--Empregados da Inglaterra
		

-- EXERCÍCIO 3

Select
			ord.orderid								--número pedido (Orders)
		,	ord.orderdate							--data pedido (Orders)
		,	cust.contactname						--nome do contato (Customers)
		,	empl.firstname							--primeiro nome (Employees)
		,	empl.lastname							--segundo nome (Employees)
		,	empl.country							--país (sem restrição) (Employees)

From 
	Sales.Orders as ord
inner join
	Sales.customers as cust
on
	ord.custid = cust.custid

inner join
	HR.Employees as empl
on	
	ord.empid = empl.empid

where empl.country = 'Brasil'						--empregados do Brasil
order by ord.orderdate desc							--ordenar por pedidos mais recentes


-- EXERCÍCIO 4
Select
			ord.orderid								--número pedido (Orders)
		,	ord.orderdate							--data pedido (Orders)
		,	cust.contactname						--nome do contato (Customers)
		,	empl.firstname							--primeiro nome (Employees)
		,	empl.lastname							--segundo nome (Employees)
		,	empl.country							--país (sem restrição) (Employees)
		,	shipe.companyname						--nome da empresa de entrega (Shippers)												

From 
	Sales.Orders as ord
inner join
	Sales.Customers as cust
on 
	ord.custid = cust.custid

inner join 
	Sales.Shippers as shipe
on 
	ord.shipperid =  shipe.shipperid

inner join
	HR.Employees as empl
on	
	ord.empid = empl.empid

where empl.country like 'United States' and shipe.companyname = 'Shipper ETYNR' or shipe.companyname ='Shipper GVSUA'										--empregados do Estados Unidos
order by ord.orderid 

-- EXERCÍCIO 5

Select
			prodt.productname									-- nome do produto (Products)
		,	catg.categoryname									-- nome da categoria (Categories)
		,	prodt.unitprice										-- preço do produto (Products)
from 
	Production.Products as prodt
inner join
	Production.Categories as catg
on
	prodt.categoryid = catg.categoryid

where catg.categoryname = 'Beverages' and prodt.unitprice < 30	--bebidas da tabela Categories com preço menor que 30
order by prodt.unitprice desc									--ordenar pelo preço

-- EXERCÍCIO 6

Select
				prodt.productname								-- nome do produto (Products)
			,	sup.companyname									-- nome da categoria (Suppliers)
			,	ordtails.qty									-- quantidade (OrderDetails)

from 
	Production.Products as prodt
inner join
	Sales.OrderDetails as ordtails
on
	prodt.productid = ordtails.productid

inner join
	Production.Suppliers as sup
on 
	prodt.supplierid = sup.supplierid 

where ordtails.qty > 100
order by prodt.productname asc , ordtails.qty desc


--EXERCÍCIO 7
select
				prodt.productname							-- nome do produto (Products)					
		,		cust.contactname							-- contato do cliente (Customers)
		,		sup.city									-- cidade do fornecedor (Suppliers)
		,		ord.orderdate								-- data do pedido (Orders)
		,		ord.empid									-- número do empregado (Orders)
		,		ordtails.qty								-- quantidade (OrderDetails)
		,		ord.orderid									-- número do pedido (Orders)
		
from 
	Production.Products as prodt
inner join
	Sales.OrderDetails as ordtails
on
	prodt.productid = ordtails.productid

inner join
	Production.Suppliers as sup
on 
	prodt.supplierid = sup.supplierid 

inner join
	Sales.Orders as ord
on
	ordtails.orderid = ord.orderid

inner join
	Sales.Customers as cust
on
	ord.custid = cust.custid

inner join
	HR.Employees as empl
on
	ord.empid = empl.empid

where year (ord.orderdate) = '2006' and month (ord.orderdate) = '7' and																	--qualquer dia do mês de julho de 2006.
	  ordtails.qty >= 20 and ordtails.qty < 60 and prodt.productname like 'Product A%' or prodt.productname like 'Product G%'and		--quantidade de produtos e suas especificações
	  sup.city in ('Stockholm','Sydney', 'Sandvika', 'Ravenna')																			--nome da cidade do fornecedor comece com A ou G

order by ord.empid desc																													--ordenar de forma descendente o número do empregado


