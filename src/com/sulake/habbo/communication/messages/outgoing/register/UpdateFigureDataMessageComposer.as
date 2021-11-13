package com.sulake.habbo.communication.messages.outgoing.register
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class UpdateFigureDataMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_690:Array = [];

        public function UpdateFigureDataMessageComposer(_arg_1:String, _arg_2:String)
        {
            _SafeStr_690.push(_arg_2);
            _SafeStr_690.push(_arg_1);
        }

        public function getMessageArray():Array
        {
            return (_SafeStr_690);
        }

        public function dispose():void
        {
            _SafeStr_690 = null;
        }


    }
}

