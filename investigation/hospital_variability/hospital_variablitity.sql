--standard deviation table.

 
DROP TABLE STDEVIATION_FT;
create table STDEVIATION_FT
as
select  inline
        (
            array
            (
                struct ('Eergency'   ,STDDEV (emergency_avg_score)  )
               ,struct ('Surgerycare'   ,STDDEV (scarei_avg_score)  )
               ,struct ('ChildrenASTH'  ,STDDEV (childasth_avg_score) )
               ,struct ('HeartFailure'    ,STDDEV (hospitalf_avg_score)   )
               ,struct ('StrokeCare'    ,STDDEV(strokec_avg_score)   )

            )
        ) as (HOSP_VAR,RANGE)
 
from    COMBINE4;    
--Print the result
SELECT  * FROM STDEVIATION_FT;
