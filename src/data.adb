-- Implementation of class called data

with Text_IO, Ada.Integer_Text_IO;
use Text_IO, Ada.Integer_Text_IO;

package body Data is
   
   procedure Find_Borders (s: out integer; f: out integer; num: in integer) is
   begin
      s:= 1+num*n/p;
      f:= (num+1)*n/p;
   end Find_Borders;
   
   --Input Vector from keyboard
   procedure Vector_Input (A: out Vector; S: in String) is
   begin
      for i in 1..n loop
         Get(A(i));
         Put(S);
         Put("[");
         Put(i);
         Put("]= ");
         Put(A(i));
         Put(" inputed");
         New_Line(1);
      end loop;
   end Vector_input;
   
   --Fill Vector with numbers
   procedure Vector_Fill (A: out Vector; B: in Integer) is
   begin
      for i in 1..n loop
         A(i):=B;
      end loop;
   end Vector_Fill;
   
   --Print Vector on screen
   procedure Vector_Output(A: in Vector) is
   begin
      for i in 1..n loop
         Put(A(i));
         Put(" ");
      end loop;
   end Vector_Output;
   
   --Input Matrix from keyboard 
   procedure Matrix_Input (A: out Matrix; S: in String) is
   begin
      for i in 1..n loop
         for j in 1..n loop
            Get(A(i)(j));
            Put(S);
            Put("[");
            Put(i);
            Put("][");
            Put(j);
            Put("]= ");
            Put(A(i)(j));
            Put(" inputed");
            New_Line(1);
         end loop;
      end loop;
   end Matrix_Input;
   
   --Fill Matrix with numbers
   procedure Matrix_Fill (A: out Matrix; B: in Integer) is
   begin
      for i in 1..n loop
         for j in 1..n loop
            A(i)(j):=B;
         end loop;
      end loop;
   end Matrix_Fill;
   
   --Print Matrix on screen
   procedure Matrix_Output (A: in Matrix) is
   begin
      for i in 1..n loop
         for j in 1..n loop
            Put(A(i)(j));
            Put(" ");
         end loop;
         New_Line(1);
      end loop;
   end Matrix_Output;
   
   --Adds the vector A to the vector B
   function Vector_Add (A,B: in Vector; num: in integer) return Vector is
      C: Vector;
      s, f: integer;
   begin
      Vector_Fill(C,0);
      Find_Borders(s,f,num);
      for i in s..f loop
         C(i):=A(i)+B(i);
      end loop;
      return C;
   end Vector_Add;
   
   --Adds the matrix A to the matrix B
   function Matrix_Add (A,B: in Matrix; num: in integer) return Matrix is
      C: Matrix;
      s, f: integer;
   begin
      Matrix_Fill(C,0);
      Find_Borders(s,f,num);
      for i in s..f loop
         for j in 1..n loop
            C(i)(j):= A(i)(j)+B(i)(j);
         end loop;
      end loop;
      return C;
   end Matrix_Add;
   
   --Multiply Matrix
   function Matrix_Multiply (A,B: in Matrix; num: in integer) return Matrix is
      C: Matrix;
      s, f: integer;
   begin
      Matrix_Fill(C,0);
      Find_Borders(s,f,num);
      for i in s..f loop
         for j in 1..n loop
            C(i)(j):=0;
            for k in 1..n loop
               C(i)(j):=C(i)(j)+A(i)(k)*B(k)(j);  
            end loop;
         end loop;
      end loop;
      return C;
   end Matrix_Multiply;
   
   --Multiply Vector on Matrix
   function Matrix_Vector_Multiply (A: in Matrix; B: in Vector; num: in integer) return Vector is
      C: Vector;
      s, f: integer;
   begin
      Vector_Fill(C,0);
      Find_Borders(s,f,num);
      for i in s..f loop
         C(i):=0;
         for j in 1..n loop
            C(i):=C(i)+A(j)(i)*B(i);
         end loop;
      end loop;
      return C;
   end Matrix_Vector_Multiply;
   
   --Multiply Matrix on Number
   function Matrix_Number_Multiply (A: in Matrix; B,num: in integer) return Matrix is
      C: Matrix;
      s, f: integer;
   begin
      Matrix_Fill(C,0);
      Find_Borders(s,f,num);
      for i in s..f loop
         for j in 1..n loop
            C(i)(j):= A(i)(j)*B;
         end loop;
      end loop;
      return C;
   end Matrix_Number_Multiply;
   
   --Calculating Func1
   --d=((A+B)*(C*(MA*ME)))
   procedure Func(A: out Vector; B,C: in Vector;MO,MK,MR: in Matrix; d: in Integer; num: in integer) is
      Res: Vector;
      s, f: integer;
   begin
      Find_Borders(s,f,num);
      Res:= Matrix_Vector_Multiply(Matrix_Add(MO,Matrix_Number_Multiply(Matrix_Multiply(MK,MR,num),d,num),num),Vector_Add(B,C,num),num);
      for i in s..f loop
         A(i):= Res(i);
      end loop;
   end Func;
   
end Data;
