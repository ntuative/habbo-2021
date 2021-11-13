package com.sulake.habbo.communication.messages.outgoing.room.engine
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class PlaceObjectMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_1922:int;
        private var _SafeStr_1924:int;
        private var _wallLocation:String;
        private var _SafeStr_954:int = 0;
        private var _SafeStr_955:int = 0;
        private var _SafeStr_1925:int = 0;

        public function PlaceObjectMessageComposer(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:int, _arg_5:int, _arg_6:int)
        {
            _SafeStr_1922 = _arg_1;
            _SafeStr_1924 = _arg_2;
            _wallLocation = _arg_3;
            _SafeStr_954 = _arg_4;
            _SafeStr_955 = _arg_5;
            _SafeStr_1925 = _arg_6;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            switch (_SafeStr_1924)
            {
                case 10:
                    return ([((((((_SafeStr_1922 + " ") + _SafeStr_954) + " ") + _SafeStr_955) + " ") + _SafeStr_1925)]);
                case 20:
                    return ([((_SafeStr_1922 + " ") + _wallLocation)]);
                default:
                    return ([]);
            };
        }


    }
}

