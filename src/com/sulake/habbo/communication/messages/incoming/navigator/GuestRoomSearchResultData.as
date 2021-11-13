package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class GuestRoomSearchResultData implements IDisposable, _SafeStr_78 
    {

        private var _searchType:int;
        private var _searchParam:String;
        private var _rooms:Array = [];
        private var _ad:OfficialRoomEntryData;
        private var _disposed:Boolean;

        public function GuestRoomSearchResultData(_arg_1:IMessageDataWrapper):void
        {
            var _local_3:int;
            super();
            _searchType = _arg_1.readInteger();
            _searchParam = _arg_1.readString();
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _rooms.push(new GuestRoomData(_arg_1));
                _local_3++;
            };
            var _local_4:Boolean = _arg_1.readBoolean();
            if (_local_4)
            {
                _ad = new OfficialRoomEntryData(_arg_1);
            };
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            _disposed = true;
            if (this._rooms != null)
            {
                for each (var _local_1:GuestRoomData in this._rooms)
                {
                    _local_1.dispose();
                };
            };
            if (_ad != null)
            {
                _ad.dispose();
                _ad = null;
            };
            this._rooms = null;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get searchType():int
        {
            return (_searchType);
        }

        public function get searchParam():String
        {
            return (_searchParam);
        }

        public function get rooms():Array
        {
            return (_rooms);
        }

        public function get ad():OfficialRoomEntryData
        {
            return (_ad);
        }


    }
}

