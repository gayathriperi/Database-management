import java.util.*;
import java.sql.*;
class 	UpdateClass
{
	String id,first_name,last_name,phoneNo,deptNo,deptName;
	public void update(Statement stmt)
	{
		try
	{
	 Scanner sc=new Scanner(System.in);
     String sql1,sql2;
	 System.out.println("1)Update  department table"); 
	 System.out.println("2)Update  first and last name  in employee table");
	 System.out.println("3)Update  phone number employee when id is given");
	 System.out.println("4)Update  email_id number employee when id is given");
	  System.out.println("5)Update  salary employee when id is given");
	 System.out.println("****enter your choice****"); 
	 int n=sc.nextInt();
		switch(n)
		{
		  case 1:
				  System.out.println("enter deptName and deptNo"); 
		          sql1="UPDATE department SET dept_name="+"\""+sc.next()+"\""+" WHERE deptNo="+sc.next()+";";
		          System.out.println("Updated");
		          stmt.executeUpdate(sql1);
		          break;
		  case 2:	  
                  System.out.println("first name , last name and id");
                  sql2="UPDATE employee SET first_empname="+"\""+sc.next()+"\""+","+"last_empname="+"\""+
            	          sc.next()+"\""+" WHERE emp_id="+sc.next()+";";
	              System.out.println(sql2);
                  stmt.executeUpdate(sql2);
		          break;
		  case 3:	 
                  System.out.println("enter  phone number and id number");
	    		  sql2="UPDATE employee SET phoneNo="+sc.next()+" WHERE emp_id="+sc.next()+";";
	              System.out.println(sql2);
	              stmt.executeUpdate(sql2);
	              break;	
         case 4:	 
                  System.out.println("enter  email_id and id number");
	    		  sql2="UPDATE employee SET email_id="+"\""+sc.next()+"\""+" WHERE emp_id="+sc.next()+";";
	              System.out.println(sql2);
	              stmt.executeUpdate(sql2);
	              break;				
		case 5:	 
                  System.out.println("enter  salary and id number");
	    		  sql2="UPDATE employee SET salary="+sc.next()+" WHERE emp_id="+sc.next()+";";
	              System.out.println(sql2);
	              stmt.executeUpdate(sql2);
	              break;				
		  	  
		  default:
  				  System.out.println("Wrong Choice");
                  break;						
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