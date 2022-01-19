use swiggy

if exists (
	 select * from DBA_ROHIT.sys.tables
		where name = 'orderdata'
	 )

begin 
	if exists(
		    select * from swiggyorderdata where  datedata <=  (select dateadd(d,-1,dateadd(year,-1,getdate())))
			)
		begin
		      insert into DBA_ROHIT.dbo.orderdata select * from swiggyorderdata where datedata <=  (select dateadd(d,-1,dateadd(year,-1,getdate())))

		      DELETE FROM swiggyorderdata WHERE datedata <=  (select dateadd(d,-1,dateadd(year,-1,getdate())));
       END
	
	ELSE 
		begin
			insert into DBA_ROHIT.dbo.orderdata select * from swiggyorderdata where  datedata <=  (select dateadd(d,-1,dateadd(year,-1,getdate())))
		    DELETE FROM swiggyorderdata WHERE datedata <=  (select dateadd(d,-1,dateadd(year,-1,getdate())));


	   END
END

ELSE

begin 
    
		
	if exists
		(   
		    select * from swiggyorderdata where  datedata <=  (select dateadd(d,-1,dateadd(year,-1,getdate())))
						

			)
		begin
		       select * into DBA_ROHIT.dbo.orderdata from  swiggyorderdata where  datedata <=  (select dateadd(d,-1,dateadd(year,-1,getdate())))

			   DELETE FROM swiggyorderdata WHERE datedata <=  (select dateadd(d,-1,dateadd(year,-1,getdate())));

		end
	
	else 
		begin
		       select * into DBA_ROHIT.dbo.orderdata from  swiggyorderdata where  datedata <=  (select dateadd(d,-1,dateadd(year,-1,getdate())))
			   DELETE FROM swiggyorderdata WHERE datedata <=  (select dateadd(d,-1,dateadd(year,-1,getdate())));

		end
END


use swiggy
select * from swiggyorderdata
use DBA_ROHIT
select * from orderdata
