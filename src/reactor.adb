package body reactor with SPARK_Mode is

   -- Removing rod will have the following effect
   procedure increaseTemp (reactor : in out ReactorState) is
   begin
      if (reactor.temp <= 80 and reactor.electricity <= 800 and reactor.water >= 10) then
         reactor.temp := reactor.temp + 20;
         reactor.water := reactor.water - 10;
         reactor.electricity := reactor.electricity + 200;
      end if;
    
      if (reactor.water < 10 or reactor.temp = 100) then
         reactor.status := Overheated;
      end if;
      
   end increaseTemp;
   
   -- Adding a rod will have the following effect
   procedure decreaseTemp (reactor : in out ReactorState) is
   begin 
      reactor.temp := reactor.temp - 20;
      reactor.electricity := reactor.electricity - 200;
   end decreaseTemp;
   
   function initialReactorState return ReactorState is
      initialstate : ReactorState := (temp => 60, water => 100, electricity => 500, status => Running);
   begin 
      return initialstate;
   end initialReactorState;
    
     
end reactor;
