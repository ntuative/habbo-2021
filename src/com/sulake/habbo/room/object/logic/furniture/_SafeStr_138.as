package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.room.object.IRoomObjectModelController;

    public class _SafeStr_138 extends FurnitureLogic 
    {


        override public function get widget():String
        {
            return ("RWE_CRAFTING");
        }

        override public function useObject():void
        {
            super.useObject();
        }

        public function setAnimationState(_arg_1:int):void
        {
            if (object == null)
            {
                return;
            };
            var _local_2:IRoomObjectModelController = object.getModelController();
            if (_local_2 != null)
            {
                _local_2.setNumber("furniture_automatic_state_index", _arg_1, false);
            };
        }


    }
}

