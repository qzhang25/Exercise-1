--standard deviation table.

 

create table STDEVIATION_FT
as
select  inline
        (
            array
            (
                struct ('EMR'   ,STDDEV (emr_avg_score)  )
               ,struct ('SCI'   ,STDDEV (sci_avg_score)  )
               ,struct ('ASTH'  ,STDDEV (asth_avg_score) )
               ,struct ('HF'    ,STDDEV (hf_avg_score)   )
               ,struct ('SC'    ,STDDEV(sc_avg_score)   )

            )
        ) as (HOSP_VAR,RANGE)
 
from    COMBINE4;    

SELECT  * FROM STDEVIATION_FT;
