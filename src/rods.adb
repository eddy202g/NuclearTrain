with Ada.Text_IO; use Ada.Text_IO;
package body Rods with SPARK_mode 
is
   
   procedure AddRod(stack : in out ChamberState; In_Char : in CHARACTER) is
   begin
      if (stack.top >= stack.slots'First and stack.top < stack.slots'Last) then
      if stack.top < stack.slots'Last then
         stack.top := stack.top + 1;
         stack.slots(stack.top) := In_Char;
         end if;   
      end if;
   end AddRod;

   procedure RemoveRod(stack : in out ChamberState) is
   begin
      if (stack.top > stack.slots'First and stack.top <= stack.slots'Last) then
         if stack.top > stack.slots'First then
            stack.top := stack.top - 1;
         end if;
      end if;
   end RemoveRod;
   
end Rods;
