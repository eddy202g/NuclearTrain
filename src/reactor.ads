with Carriage; use Carriage;

package reactor with SPARK_Mode is 

   type temperatureLevel is range 0..100;
   type waterLevel is range 0..100;
   type elecLevel is range 0..1000;
   type RunningOverOff is (Running, Overheated, Offline);
   
   type ReactorState is record
      temp : temperatureLevel;
      water : waterLevel;
      electricity : elecLevel;
      status : RunningOverOff;
   end record;
   
   procedure increaseTemp (reactor : in out ReactorState) with
     Pre => reactor.temp <= 80 and reactor.electricity <= 800 and reactor.water >= 10, 
     Post => reactor.temp > reactor.temp'Old and reactor.water < reactor.water'Old;
   
   procedure decreaseTemp (reactor : in out ReactorState) with
     Pre => reactor.temp >= 20 and reactor.electricity >= 200,
     Post => reactor.temp < reactor.temp'Old and reactor.electricity < reactor.electricity'Old;
   
   function initialReactorState return ReactorState;
   
   

end reactor;
