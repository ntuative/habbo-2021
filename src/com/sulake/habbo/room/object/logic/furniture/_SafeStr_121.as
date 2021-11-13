package com.sulake.habbo.room.object.logic.furniture
{
    public class _SafeStr_121 extends FurnitureMultiStateLogic 
    {


        override public function get widget():String
        {
            return ("RWE_CUSTOM_STACK_HEIGHT");
        }

        override public function initialize(_arg_1:XML):void
        {
            super.initialize(_arg_1);
            if (((!(object == null)) && (!(object.getModelController() == null))))
            {
                object.getModelController().setNumber("furniture_always_stackable", 1);
            };
        }


    }
}

