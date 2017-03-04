--standard deviation table.

 

create table STD_FT
as
select  inline
        (
            array
            (
                struct ('EMR'   ,STDDEV (emr_avg_score)  )
               ,struct ('SCI'   ,STDDEV (sci_avg_score)  )
               ,struct ('ASTH'  ,STDDEV (asth_avg_score) )
               ,struct ('HF'    ,STDDEV (hf_avg_score)   )
               ,struct ('SC'    ,STDDEV (sc_avg_score)   )
               ,struct ('PNEU'  ,STDDEV (pneu_avg_score) )
               ,struct ('PREV'  ,STDDEV (prev_avg_score) )
               ,struct ('BC'    ,STDDEV (BC_avg_score)   )
               ,struct ('HEART' ,STDDEV (heart_avg_score))
               ,struct ('PREG'  ,STDDEV (preg_avg_score) )
            )
        ) as (HOSP_VAR,RANGE)
 
from    JOIN9    

SELECT  * STD_FT;
