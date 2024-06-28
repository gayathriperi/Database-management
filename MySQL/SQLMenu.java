import java.util.*;
import java.sql.*;
public class SQLMenu
{
  static final String JDBC_DRIVER="com.mysql.cj.jdbc.Driver";
  static final String DB_URL="jdbc:mysql://localhost/kmitStaff?useSSL=false";
  static final String USER="root";
  static final String PASS="1050630";
  
  public static void main(String[] args)
  {
    Connection conn=null;
	Statement stmt=null;
	int n=0;
	try
	  {
		  
		 Class.forName("com.mysql.cj.jdbc.Driver");
		 System.out.println("Connecting to Database.....");
		 conn=DriverManager.getConnection(DB_URL,USER,PASS);
		 System.out.println("Creating statement...");
		 stmt=conn.createStatement();
		 char ch;
		 do
		 {
	     Scanner sc=new Scanner(System.in);
		         for(int i=1;i<=5;i++)//pattern
	             {
		         for(int k=1;k<i;k++)
		         { 
		    	 System.out.print(" ");
		         }
		         for(int j=i;j<=5;j++)
		         {
			     System.out.print("* ");
		         }
		         System.out.println();
	             }
		 System.out.println("1)Insert records  both in employee and department"); 
    	 System.out.println("2)Update records  both in employee and department");
		 System.out.println("3)Delete records  both in employee and department");	
		 System.out.println("4)Display records  both in employee and department");
		 System.out.println("5)other calculations");
		          for(int i=5;i>=1;i--)//pattern
	              {
                 for(int j=1;j<i;j++)
		          {
			     System.out.print(" ");
		          }
		         for(int k=i;k<=5;k++)
		         {
			     System.out.print("* ");
		         }
		         System.out.println();
				  }
		 System.out.println("*****enter your choice*****");
		 n=sc.nextInt();
		 switch(n)
		 {
			 case 1:InsertClass m=new InsertClass();
			        m.insert(stmt);
			         break;
			 case 2:UpdateClass u=new UpdateClass();
			         u.update(stmt);
			        break;
             case 3:DeleteClass  de=new DeleteClass(); 
			         de.delete(stmt);
			          break;
             case 4:DisplayClass d=new DisplayClass();
			        d.display(stmt);
			        break;
			 case 5:Other o=new Other();
			        o.otherCal(stmt);
			        break;
             default:
			         System.out.println("Wrong Choice");					
		 }
		
       System.out.println("Do you want to continue(type y (or) n)");
		ch=sc.next().charAt(0);
	}while(ch=='y' || ch=='Y');
	  }
  catch(SQLException se)
	  {
		  se.printStackTrace();
	  }
	  catch(Exception e)
	  {
		  e.printStackTrace();
	   
	  } 
	        finally
	        	{	
			          try
		             {
			         if(stmt!=null)
				       stmt.close();
		              }
		           catch(SQLException se){}
		           try
		           {
			       if(conn!=null)
			      conn.close();
		            }
		           catch(SQLException se)
		             {
			         se.printStackTrace();
		             }
		             System.out.println("GoodBye!");
	                 }
  }	
	      
}
}


class Other
{
	public void otherCal(Statement stmt)
	{
		try
		{
		Scanner sc=new Scanner(System.in);
	    System.out.println("1)Maximum Salary package");
		System.out.println("2)Minimum Salary package");
		System.out.println("*****enter your choice*******");
	    int n=sc.nextInt();
		 switch(n)
		 {
		   case 1:String sql;
		          sql="SELECT MAX(salary) FROM employee;";
				  //System.out.println(sql);
                  ResultSet rs=stmt.executeQuery(sql);
				  while(rs.next())
				  {
					  String salary=rs.getString("MAX(salary)");
                      System.out.print("salary: "+salary);
					  
				  }
				  break;
		   case 2:String sql1;
		          sql1="SELECT MIN(salary) FROM employee;";
				  //System.out.println(sql);
                  ResultSet rs1=stmt.executeQuery(sql1);
				  while(rs1.next())
				  {
					  String salary=rs1.getString("MIN(salary)");
                      System.out.print("salary: "+salary);
					  
				  }
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