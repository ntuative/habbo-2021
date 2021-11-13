package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class OfficialRoomEntryData implements IDisposable 
    {

        public static const _SafeStr_1806:int = 1;
        public static const _SafeStr_1807:int = 2;
        public static const _SafeStr_1808:int = 4;

        private var _index:int;
        private var _popupCaption:String;
        private var _popupDesc:String;
        private var _showDetails:Boolean;
        private var _picText:String;
        private var _picRef:String;
        private var _folderId:int;
        private var _userCount:int;
        private var _type:int;
        private var _tag:String;
        private var _guestRoomData:GuestRoomData;
        private var _open:Boolean;
        private var _disposed:Boolean;

        public function OfficialRoomEntryData(_arg_1:IMessageDataWrapper)
        {
            _index = _arg_1.readInteger();
            _popupCaption = _arg_1.readString();
            _popupDesc = _arg_1.readString();
            _showDetails = (_arg_1.readInteger() == 1);
            _picText = _arg_1.readString();
            _picRef = _arg_1.readString();
            _folderId = _arg_1.readInteger();
            _userCount = _arg_1.readInteger();
            _type = _arg_1.readInteger();
            if (_type == 1)
            {
                _tag = _arg_1.readString();
            }
            else
            {
                if (_type == 2)
                {
                    _guestRoomData = new GuestRoomData(_arg_1);
                }
                else
                {
                    _open = _arg_1.readBoolean();
                };
            };
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            _disposed = true;
            if (this._guestRoomData != null)
            {
                this._guestRoomData.dispose();
                this._guestRoomData = null;
            };
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get type():int
        {
            return (_type);
        }

        public function get index():int
        {
            return (_index);
        }

        public function get popupCaption():String
        {
            return (_popupCaption);
        }

        public function get popupDesc():String
        {
            return (_popupDesc);
        }

        public function get showDetails():Boolean
        {
            return (_showDetails);
        }

        public function get picText():String
        {
            return (_picText);
        }

        public function get picRef():String
        {
            return (_picRef);
        }

        public function get folderId():int
        {
            return (_folderId);
        }

        public function get tag():String
        {
            return (_tag);
        }

        public function get userCount():int
        {
            return (_userCount);
        }

        public function get guestRoomData():GuestRoomData
        {
            return (_guestRoomData);
        }

        public function get open():Boolean
        {
            return (_open);
        }

        public function toggleOpen():void
        {
            _open = (!(_open));
        }

        public function get maxUsers():int
        {
            if (this.type == 1)
            {
                return (0);
            };
            if (this.type == 2)
            {
                return (this._guestRoomData.maxUserCount);
            };
            return (0);
        }


    }
}

