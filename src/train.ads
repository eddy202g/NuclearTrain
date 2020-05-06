with Carriage; use Carriage;
with Rods; use Rods;
with reactor; use reactor;


package Train with SPARK_Mode is

   subtype Speed is Integer range 0..120;
      
   type TrainRecord  is record 
      currentSpeed : Speed := 100;
      reactor : ReactorState := initialReactorState;
      rods : ChamberState;
   end record;
   
   procedure StopTrain(t: in out TrainRecord) with
     Pre => t.reactor.status = Running and t.currentSpeed > Speed'First,
     Post => t.currentSpeed = Speed'First;
   
   procedure EmergencyStop(t : in out TrainRecord) with
     Pre => t.reactor.status = Overheated and t.currentSpeed > Speed'First,
     Post => t.currentSpeed = Speed'First;
   
   procedure DisableReactor(t : in out TrainRecord) with
     Pre => t.currentSpeed = Speed'First and t.reactor.status = Overheated,
     Post => t.reactor.temp = 0 and t.reactor.electricity = 0 and t.reactor.status = Offline; 
   
   procedure RestartTrain(t : in out TrainRecord) with 
     Pre => t.currentSpeed = Speed'First,
     Post => t.currentSpeed > Speed'First and 
     (if t.reactor.status = Offline then t.reactor = initialReactorState);
          
   procedure RegulateSpeed(t : in out TrainRecord) with
     Pre => t.currentSpeed > Speed'First and t.currentSpeed <= Speed'Last,
     Post => t.currentSpeed >= t.currentSpeed'Old or t.currentSpeed <= t.currentSpeed'Old;  
  
end Train;
