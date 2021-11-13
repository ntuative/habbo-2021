package com.sulake.habbo.communication.messages.outgoing.room.layout
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class UpdateFloorPropertiesMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_875:Array;

        public function UpdateFloorPropertiesMessageComposer(_arg_1:String, _arg_2:int=-1, _arg_3:int=-1, _arg_4:int=-1, _arg_5:int=-1, _arg_6:int=-1, _arg_7:int=-1)
        {
            if ((((((_arg_2 == -1) && (_arg_3 == -1)) && (_arg_4 == -1)) && (_arg_5 == -1)) && (_arg_6 == -1)))
            {
                _SafeStr_875 = [_arg_1];
            }
            else
            {
                if (_arg_7 == -1)
                {
                    _SafeStr_875 = [_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6];
                }
                else
                {
                    _SafeStr_875 = [_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7];
                };
            };
        }

        public function getMessageArray():Array
        {
            return (_SafeStr_875);
        }

        public function dispose():void
        {
            _SafeStr_875 = null;
        }


    }
}

