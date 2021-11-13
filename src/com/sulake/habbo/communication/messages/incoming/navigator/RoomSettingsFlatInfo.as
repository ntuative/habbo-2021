package com.sulake.habbo.communication.messages.incoming.navigator
{
        public class RoomSettingsFlatInfo 
    {

        public static const _SafeStr_1809:int = 0;
        public static const _SafeStr_1810:int = 1;
        public static const _SafeStr_1811:int = 2;
        public static const _SafeStr_1812:int = 3;
        public static const _SafeStr_1813:int = 4;

        private var _allowFurniMoving:Boolean;
        private var _doorMode:int;
        private var _id:int;
        private var _ownerName:String;
        private var _type:String;
        private var _name:String;
        private var _description:String;
        private var _showOwnerName:Boolean;
        private var _allowTrading:Boolean;
        private var _categoryAlertKey:Boolean;
        private var _password:String;


        public function get allowFurniMoving():Boolean
        {
            return (_allowFurniMoving);
        }

        public function get doorMode():int
        {
            return (_doorMode);
        }

        public function get id():int
        {
            return (_id);
        }

        public function get ownerName():String
        {
            return (_ownerName);
        }

        public function get type():String
        {
            return (_type);
        }

        public function get name():String
        {
            return (_name);
        }

        public function get description():String
        {
            return (_description);
        }

        public function get showOwnerName():Boolean
        {
            return (_showOwnerName);
        }

        public function get allowTrading():Boolean
        {
            return (_allowTrading);
        }

        public function get categoryAlertKey():Boolean
        {
            return (_categoryAlertKey);
        }

        public function get password():String
        {
            return (_password);
        }

        public function set allowFurniMoving(_arg_1:Boolean):void
        {
            _allowFurniMoving = _arg_1;
        }

        public function set doorMode(_arg_1:int):void
        {
            _doorMode = _arg_1;
        }

        public function set id(_arg_1:int):void
        {
            _id = _arg_1;
        }

        public function set ownerName(_arg_1:String):void
        {
            _ownerName = _arg_1;
        }

        public function set type(_arg_1:String):void
        {
            _type = _arg_1;
        }

        public function set name(_arg_1:String):void
        {
            _name = _arg_1;
        }

        public function set description(_arg_1:String):void
        {
            _description = _arg_1;
        }

        public function set showOwnerName(_arg_1:Boolean):void
        {
            _showOwnerName = _arg_1;
        }

        public function set allowTrading(_arg_1:Boolean):void
        {
            _allowTrading = _arg_1;
        }

        public function set categoryAlertKey(_arg_1:Boolean):void
        {
            _categoryAlertKey = _arg_1;
        }

        public function set password(_arg_1:String):void
        {
            _password = _arg_1;
        }


    }
}

