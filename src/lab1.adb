-- Laboratory work on the topic: "Ada. Semaphores"
-- Variant: A = ( B + C ) * ( MO + d * ( MK * MR ) )
-- Created: 8.02.2018 8:52 PM
-- Author: Obozniy Dmitriy IO-51


with Data, Ada.Text_IO, Ada.Integer_Text_IO, Ada.Synchronous_Task_Control;
use Ada.Text_IO, Ada.Integer_Text_IO, Ada.Synchronous_Task_Control;


procedure Lab1 is

   N: integer := 500;   -- vector size
   P: integer := 2;    -- processors count
   H: integer := N/P;  -- subvector size

   d: integer;  -- shared resource (global variable)

   package datax is new Data (n,p);
   use datax;

   C, A, B: Vector;    -- shared resource and global variables
   MO, MK, MR: Matrix; -- shared resource and global variables

   -- semaphores
   Sem1, Sem2, Sem3, Skd: Suspension_Object;

   procedure Task_Begin is

      task T1 is
         pragma Task_Name("Task1");
         pragma Priority(5);
         pragma Storage_Size(30000000);
      end T1;


      task body T1 is
         --local variables
         d1: integer;
         C1: Vector;
         MO1: Matrix;
      begin
         put_line("Process T1 started ");
         -- input B, C and MR
         if n<=1 then
            Vector_Input(B,"B");
            Vector_Input(C,"C");
            Matrix_Input(MR,"MR");
         else
            Vector_Fill(B,1);
            Vector_Fill(C,1);
            Matrix_Fill(MR,1);
         end if;

         -- signal for task T2 about end of input B, C and MR
         Set_True(Sem1);

         -- waiting for end of input in task T2
         Suspend_Until_True(Sem2);

         -- copy d in d1, C in C1, MO in MO1
         Suspend_Until_True(Skd);
         -- critical zone
         d1:= d;
         C1:= C;
         MO1:= MO;
         Set_True(Skd);

         -- Calculating AH
         Func(A,B,C1,MO1,MK,MR,d1,0);

         -- waiting for end of calculating in T2
         Suspend_Until_True(Sem3);

         -- output the result
         if N<=10 then
            Put_Line("A: ");
            Vector_Output(A);
            put_line("");
         end if;

         put_line("Process T1 finished");
      end T1;

      task T2 is
         pragma Task_Name("Task2");
         pragma Priority(5);
         pragma Storage_Size(30000000);
      end T2;

      task body T2 is
         -- local variables
         d2: integer;
         C2: Vector;
         MO2: Matrix;
      begin
         put_line("Process T2 started ");
         -- input MO, MK and d
         if n<=1 then
            Matrix_Input(MO,"MO");
            Matrix_Input(MK,"MK");
         else
            Matrix_Fill(MO,1);
            Matrix_Fill(MK,1);
         end if;

         d:= 1;

         -- signal for task T1 about end of input MO, MK and d
         Set_True(Sem2);

         -- waiting for end of input in task T1
         Suspend_Until_True(Sem1);

         -- copy d in d2, C in C2, MO in MO2
         Suspend_Until_True(Skd);
         d2:= d;
         C2:= C;
         MO2:= MO;
         Set_True(Skd);

         -- Calculating AH
         Func(A,B,C2,MO2,MK,MR,d2,1);

         -- signal for T1 about end of calculating
         Set_True(Sem3);

         put_line("Process T2 finished");
      end T2;
   begin
      null;
   end Task_Begin;

-- body of main program
begin

   put_line("Main procedure started ");

   -- setting start value of semaphore Skd
   Set_True(Skd);

   Task_Begin;

end Lab1;
