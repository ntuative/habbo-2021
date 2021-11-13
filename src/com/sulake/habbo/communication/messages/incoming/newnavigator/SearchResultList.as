package com.sulake.habbo.communication.messages.incoming.newnavigator
{
    import __AS3__.vec.Vector;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class SearchResultList 
    {

        public static const _SafeStr_1814:int = 0;
        public static const _SafeStr_1815:int = 1;
        public static const _SafeStr_1816:int = 2;

        private var _searchCode:String;
        private var _text:String;
        private var _actionAllowed:int;
        private var _forceClosed:Boolean;
        private var _viewMode:int;
        private var _guestRooms:Vector.<GuestRoomData> = new Vector.<GuestRoomData>(0);

        public function SearchResultList(_arg_1:IMessageDataWrapper)
        {
            var _local_3:int;
            super();
            _searchCode = _arg_1.readString();
            _text = _arg_1.readString();
            _actionAllowed = _arg_1.readInteger();
            _forceClosed = _arg_1.readBoolean();
            _viewMode = _arg_1.readInteger();
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _guestRooms.push(new GuestRoomData(_arg_1));
                _local_3++;
            };
        }

        public function get guestRooms():Vector.<GuestRoomData>
        {
            return (_guestRooms);
        }

        public function get searchCode():String
        {
            return (_searchCode);
        }

        public function get text():String
        {
            return (_text);
        }

        public function get actionAllowed():int
        {
            return (_actionAllowed);
        }

        public function get forceClosed():Boolean
        {
            return (_forceClosed);
        }

        public function get viewMode():int
        {
            return (_viewMode);
        }

        public function set viewMode(_arg_1:int):void
        {
            _viewMode = _arg_1;
        }

        public function findGuestRoom(_arg_1:int):GuestRoomData
        {
            for each (var _local_2:GuestRoomData in _guestRooms)
            {
                if (_local_2.flatId == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (null);
        }


    }
}

