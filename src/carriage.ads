package Carriage with SPARK_Mode
is  
   
   -- Handle the carriage states --
   type CoupledDecoupled is (Coupled, Decoupled); -- Handles whether knuckes are coupled or not
   type LockedUnlocked is (Locked, Unlocked); -- Handles whether or not the pin is inserted  
   
   type CarriageRecord is record 
      knuckle: CoupledDecoupled;
      pin : LockedUnlocked;   
   end record;
   
   -- Initialise carriage status
   C1 : CarriageRecord := (knuckle => Coupled, pin => Locked);
   C2 : CarriageRecord := (knuckle => Decoupled, pin => Unlocked);
   C3 : CarriageRecord := (knuckle => Decoupled, pin => Unlocked);
   

   procedure removeCarriage (thisCarriage : in out CarriageRecord) with
     Pre => thisCarriage.knuckle = Coupled and thisCarriage.pin = Locked,
     Post => thisCarriage.pin = Unlocked and thisCarriage.knuckle = Decoupled;
   
   procedure addCarriage (thisCarriage : in out CarriageRecord) with
     Pre => thisCarriage.pin = Unlocked and thisCarriage.knuckle = Decoupled,
     Post => thisCarriage.knuckle = Coupled and thisCarriage.pin = Locked;
   
   function carriageCount return Integer;
   
end Carriage;
