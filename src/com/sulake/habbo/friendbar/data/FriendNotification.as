package com.sulake.habbo.friendbar.data
{
    public class FriendNotification implements IFriendNotification 
    {

        public static const TYPE_MESSENGER:int = -1;
        public static const _SafeStr_2224:int = 0;
        public static const _SafeStr_2225:int = 1;
        public static const TYPE_QUEST:int = 2;
        public static const TYPE_PLAYING_GAME:int = 3;
        public static const TYPE_FINISHED_GAME:int = 4;

        private var _typeCode:int = -1;
        private var _message:String;
        private var _viewOnce:Boolean;

        public function FriendNotification(_arg_1:int, _arg_2:String, _arg_3:Boolean)
        {
            this._typeCode = _arg_1;
            this._message = _arg_2;
            this._viewOnce = _arg_3;
        }

        public static function typeCodeToString(_arg_1:int):String
        {
            switch (_arg_1)
            {
                case -1:
                    return ("instant_message");
                case 0:
                    return ("room_event");
                case 1:
                    return ("achievement");
                case 2:
                    return ("quest");
                case 3:
                    return ("playing_game");
                case 4:
                    return ("finished_game");
                default:
                    return ("unknown");
            };
        }


        public function get typeCode():int
        {
            return (_typeCode);
        }

        public function set typeCode(_arg_1:int):void
        {
            _typeCode = _arg_1;
        }

        public function get message():String
        {
            return (_message);
        }

        public function set message(_arg_1:String):void
        {
            _message = _arg_1;
        }

        public function get viewOnce():Boolean
        {
            return (_viewOnce);
        }

        public function set viewOnce(_arg_1:Boolean):void
        {
            _viewOnce = _arg_1;
        }


    }
}

