import java.sql.*;
import java.util.*;
class DeleteClass
{
    static String id,first_name,last_name,phoneNo,deptNo,deptName;
	public void delete(Statement stmt)
	{
		try
		{
		     Scanner sc=new Scanner(System.in);
		     String sql1,sql2;
			 System.out.println("1)Delete  records  of  department table"); 
			 System.out.println("2)Delete  records  of  employee table");
			 System.out.println("3)Delete specific record of employee when id is given");
			 System.out.println("4)Delete specific record of delete when id is given");
			 System.out.println("*****enter your choice******"); 
		    int n=sc.nextInt();
		    switch(n)
		   {
			 case 1:
			        
			        sql1="DELETE FROM department;";
		            System.out.println("records of department and employee are deleted");
		            stmt.executeUpdate(sql1);
		            break;
			 case 2:
			       sql2="DELETE FROM employee";
				   System.out.println("records of department and employee are deleted");
		           stmt.executeUpdate(sql2);
				   break;
		     case 3:
			         System.out.println("enter the employee id");
			         sql2="DELETE FROM employee Where ";
		             sql2=sql2+"emp_id="+sc.next()+";";
				     System.out.println("records of employee id is deleted");
		             stmt.executeUpdate(sql2);
		             break;
			
			 case 4:
			       System.out.println("enter the department deptNo");
			       sql1="DELETE FROM department Where ";
		           sql1=sql1+"deptNo="+sc.next()+";";
				   System.out.println("records of department deptNo is deleted");
		           stmt.executeUpdate(sql1);
		            break;
			 		 
		     default :System.out.println("Wrong Choice"); 
		   }
	}
	catch(SQLException se)
	  {
		  se.printStackTrace();
	  }
	  catch(Exception e)
	  {
		  e.printStackTrace();
	   
	  }		
}
}