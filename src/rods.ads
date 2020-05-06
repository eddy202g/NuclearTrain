package Rods with SPARK_mode 
is
   
   Maximum_Size : constant := 5;
   type Stack_List is array (1..Maximum_Size) of Character;
   
   type ChamberState is record
      slots : Stack_List;
      top : INTEGER := 3;
   end record;
      
   procedure AddRod(stack : in out ChamberState; In_Char  : in CHARACTER) with
     Pre => stack.top >= stack.slots'First and stack.top < stack.slots'Last,
     Post => stack.top > stack.top'Old;      
   
   procedure RemoveRod(stack : in out ChamberState) with
     Pre => stack.top > stack.slots'First and stack.top <= stack.slots'Last,
     Post => stack.top'Old > stack.top;
   
end Rods;
