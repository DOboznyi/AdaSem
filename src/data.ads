-- Specification of class called data
-- This class is generic type class

generic
   n:Integer; -- Parametr used in class
   p:Integer;
package data is
   
   --Declaration of private types
   
   type Vector is private;
   type Matrix is private;
  
   --Input Vector from keyboard   
   procedure Vector_Input(A: out Vector; S: in String);
   
   --Fill Vector with 1   
   procedure Vector_Fill(A: out Vector; B: in Integer);
   
   --Print Vector on screen
   procedure Vector_Output(A: in Vector);
    
   --Input Matrix from keyboard 
   procedure Matrix_Input(A: out Matrix; S: in String);
   
   --Fill Matrix with 1
   procedure Matrix_Fill(A: out Matrix; B: in Integer);
   
   --Print Matrix on screen
   procedure Matrix_Output(A: in Matrix);
   
   --Calculating Func1
   procedure Func(A: out Vector; B,C: in Vector;MO,MK,MR: in Matrix; d: in Integer; num: in integer);
   
   --Determination declarated private types
    
private
   type Vector is array (1..n) of Integer;
   type Matrix is array (1..n) of Vector;
    
end Data;
