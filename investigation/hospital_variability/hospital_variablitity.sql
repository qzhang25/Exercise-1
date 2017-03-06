--standard deviation table.

 
DROP TABLE STDEVIATION_FT;
create table STDEVIATION_FT
as
select  inline
        (
            array
            (
                struct ('EMR'   ,STDDEV (emergency_avg_score)  )
               ,struct ('SCI'   ,STDDEV (scarei_avg_score)  )
               ,struct ('ASTH'  ,STDDEV (childasth_avg_score) )
               ,struct ('HF'    ,STDDEV (hospitalf_avg_score)   )
               ,struct ('SC'    ,STDDEV(strokec_avg_score)   )

            )
        ) as (HOSP_VAR,RANGE)
 
from    COMBINE4;    
--Print the result
SELECT  * FROM STDEVIATION_FT;
