package com.sulake.habbo.communication.messages.outgoing.room.engine
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.utils.Map;

        public class SetObjectDataMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_690:Array = [];

        public function SetObjectDataMessageComposer(_arg_1:int, _arg_2:Map)
        {
            _SafeStr_690.push(_arg_1);
            _SafeStr_690.push((_arg_2.length * 2));
            for each (var _local_3:String in _arg_2.getKeys())
            {
                _SafeStr_690.push(_local_3);
                _SafeStr_690.push(_arg_2.getValue(_local_3));
            };
        }

        public function dispose():void
        {
            _SafeStr_690 = null;
        }

        public function getMessageArray():Array
        {
            return (_SafeStr_690);
        }


    }
}

