package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.room.object.IRoomObjectModelController;

    public class FurniturePlanetSystemLogic extends FurnitureLogic 
    {


        override public function initialize(_arg_1:XML):void
        {
            var _local_3:IRoomObjectModelController;
            super.initialize(_arg_1);
            if (_arg_1 == null)
            {
                return;
            };
            var _local_2:XMLList = _arg_1.planetsystem;
            if (_local_2.length() == 0)
            {
                return;
            };
            if (object != null)
            {
                _local_3 = object.getModelController();
                if (_local_3 != null)
                {
                    _local_3.setString("furniture_planetsystem_data", _local_2);
                };
            };
        }


    }
}