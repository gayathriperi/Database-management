import java.util.*;
import java.sql.*;
class 	DisplayClass
{
   public void display(Statement stmt)
   {
	  try{  
	        ResultSet rs3,rs4;
			Scanner sc=new Scanner(System.in);
			System.out.println("1)display data of department table");
		    System.out.println("2)display data of employee table");
		    System.out.println("*****enter your choice*****");
		    int n=sc.nextInt();
		   switch(n)
		   {
		    case 1:
        	      rs3=stmt.executeQuery("SELECT*FROM department;");
	              while(rs3.next())
				  {
			      int deptNo=rs3.getInt("deptNo");
			      String deptname=rs3.getString("deptName");
			      System.out.print("ID: "+deptNo+" ");
			      System.out.print("NAME: "+deptname+" ");
			      System.out.println();
		          }
				  break;
			case 2:	  
		          rs4=stmt.executeQuery("SELECT*FROM employee;");
		          while(rs4.next())
				  {
			      int id=rs4.getInt("emp_id");
			      String first_name=rs4.getString("first_name");
			      String last_name=rs4.getString("last_name");
			      String phoneNo=rs4.getString("phoneNo");
				  String email_id=rs4.getString("email_id");
				  String salary=rs4.getString("salary");
			      System.out.print("ID: "+id+" ");
			      System.out.print("first NAME: "+first_name+" ");
			      System.out.print("last NAME: "+last_name+" ");
			      System.out.print("phone no.: "+phoneNo+" ");
				  System.out.print("email_id: "+email_id+" ");
			      System.out.print("salary: "+salary+" ");
			      System.out.println();
		          }
				  break;
			default :
                  System.out.println("Wrong Choice");			
	  
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