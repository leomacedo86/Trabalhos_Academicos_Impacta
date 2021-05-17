
-- 1. LISTAR A SOMA DE VALOR TOTAL DOS PEDIDOS E QUANTIDADE DE PEDIDOS POR ANO DE EMISSÃO DA NOTA FISCAL
--SELECT TOP 1 * FROM TB_PEDIDO


-- 2. LISTAR A MÉDIA DE PRECO DE CUSTO E A MÉDIA DE PRECO DE VENDA PARA TODOS OS PRODUTOS QUE POSSUAM QUANTIDADE REAL SUPERIOR A 4500
--SELECT TOP 1 * FROM TB_PRODUTO


-- 3. SELECIONAR A MÉDIA DE QUANTIDADE E A SOMA DE PREÇO UNITÁRIO, AGRUPANDO POR ANO E MÊS DE ENTREGA
-- OBS.: TRAZER O ANO E MÊS EM FORMATO AAAA/MM (FORMATO DE RELATÓRIO)
--SELECT TOP 1 * FROM TB_ITENSPEDIDO

-- SELECIONE A SOMA DE PREMIO MENSAL POR CARGO, APENAS PARA OS CARGOS QUE POSSUEM MAIS DO QUE 5000 DE SOMA


Select	year (data_emissao) as ano_emissao_nota,
		sum(vlr_total) as soma_vlr_total,
		count(num_pedido) as quantidade_pedidos
		
from TB_PEDIDO

group by year(data_emissao)
order by year(data_emissao)

Select	descricao, 
		avg(preco_custo) as media_prec_custo, 
		avg(preco_venda) as media_prec_venda 

from TB_PRODUTO

where qtd_real > '4500'
group by descricao

Select	format(data_entrega,'yyyy/MM') as ano_mes,
		avg(quantidade) as media_quantidade,
		sum(pr_unitario) as soma_prec_unitario
		
FROM TB_ITENSPEDIDO

group by format(data_entrega,'yyyy/MM')
order by format(data_entrega,'yyyy/MM')


	
