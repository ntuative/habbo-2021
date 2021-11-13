package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class SetMannequinFigureComposer implements IMessageComposer 
    {

        private var _SafeStr_1936:int;

        public function SetMannequinFigureComposer(_arg_1:int)
        {
            _SafeStr_1936 = _arg_1;
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1936]);
        }

        public function dispose():void
        {
        }


    }
}

