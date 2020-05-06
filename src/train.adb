with Carriage; use Carriage;
with Rods; use Rods;
with reactor; use reactor;
package body Train with SPARK_Mode is

   procedure StopTrain(t: in out TrainRecord) is
   begin
        if (t.reactor.status = Running and t.currentSpeed > Speed'First) then
         t.currentSpeed := Speed'First;
         end if;
        end StopTrain;

   procedure EmergencyStop(t : in out TrainRecord) is
   begin
        if (t.reactor.status = Overheated and t.currentSpeed > Speed'First) then
         t.currentSpeed := Speed'First;
         end if;
   end EmergencyStop;

   procedure DisableReactor(t : in out TrainRecord) is
   begin
      if (t.currentSpeed = Speed'First and t.reactor.status = Overheated) then
      t.reactor.temp := 0;
      t.reactor.electricity := 0;
         t.reactor.status := Offline;
         end if;
   end DisableReactor;

   procedure RestartTrain(t : in out TrainRecord) is
   begin
      if (t.currentSpeed = Speed'First) then
         if (t.reactor.status) = Offline then
            t.reactor := initialReactorState;
         end if;
            t.currentSpeed := 100;
         end if;
   end RestartTrain;

   procedure RegulateSpeed(t : in out TrainRecord) is
   begin
      if (t.currentSpeed > Speed'First and t.currentSpeed <= Speed'Last) then
         if (carriageCount = 2) then
            t.currentSpeed :=  85;
         else if (carriageCount = 3) then
               t.currentSpeed := 65;
            else
               t.currentSpeed := 100;
            end if;
         end if;

         if (t.reactor.electricity >= 700) then
            t.currentSpeed := t.currentSpeed + 20;
         elsif (t.reactor.electricity > 0 and t.reactor.electricity <= 500) then
            t.currentSpeed := t.currentSpeed - 20;
         end if;

      end if;

      end RegulateSpeed;


end Train;
