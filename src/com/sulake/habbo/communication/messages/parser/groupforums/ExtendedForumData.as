package com.sulake.habbo.communication.messages.parser.groupforums
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ExtendedForumData extends ForumData 
    {

        private var _readPermissions:int;
        private var _postMessagePermissions:int;
        private var _postThreadPermissions:int;
        private var _moderatePermissions:int;
        private var _readPermissionError:String;
        private var _postMessagePermissionError:String;
        private var _postThreadPermissionError:String;
        private var _moderatePermissionError:String;
        private var _reportPermissionError:String;
        private var _canChangeSettings:Boolean;
        private var _isStaff:Boolean;


        public static function readFromMessage(_arg_1:IMessageDataWrapper):ExtendedForumData
        {
            var _local_2:ExtendedForumData = new ExtendedForumData();
            ForumData.fillFromMessage(_local_2, _arg_1);
            _local_2._readPermissions = _arg_1.readInteger();
            _local_2._postMessagePermissions = _arg_1.readInteger();
            _local_2._postThreadPermissions = _arg_1.readInteger();
            _local_2._moderatePermissions = _arg_1.readInteger();
            _local_2._readPermissionError = _arg_1.readString();
            _local_2._postMessagePermissionError = _arg_1.readString();
            _local_2._postThreadPermissionError = _arg_1.readString();
            _local_2._moderatePermissionError = _arg_1.readString();
            _local_2._reportPermissionError = _arg_1.readString();
            _local_2._canChangeSettings = _arg_1.readBoolean();
            _local_2._isStaff = _arg_1.readBoolean();
            return (_local_2);
        }


        public function get readPermissions():int
        {
            return (_readPermissions);
        }

        public function get postMessagePermissions():int
        {
            return (_postMessagePermissions);
        }

        public function get postThreadPermissions():int
        {
            return (_postThreadPermissions);
        }

        public function get moderatePermissions():int
        {
            return (_moderatePermissions);
        }

        public function get canRead():Boolean
        {
            return (_readPermissionError.length == 0);
        }

        public function get canReport():Boolean
        {
            return (true);
        }

        public function get canPostMessage():Boolean
        {
            return (_postMessagePermissionError.length == 0);
        }

        public function get canPostThread():Boolean
        {
            return (_postThreadPermissionError.length == 0);
        }

        public function get canModerate():Boolean
        {
            return (_moderatePermissionError.length == 0);
        }

        public function get canChangeSettings():Boolean
        {
            return (_canChangeSettings);
        }

        public function get isStaff():Boolean
        {
            return (_isStaff);
        }

        public function get readPermissionError():String
        {
            return (_readPermissionError);
        }

        public function get postMessagePermissionError():String
        {
            return (_postMessagePermissionError);
        }

        public function get postThreadPermissionError():String
        {
            return (_postThreadPermissionError);
        }

        public function get moderatePermissionError():String
        {
            return (_moderatePermissionError);
        }

        public function get reportPermissionError():String
        {
            return (_reportPermissionError);
        }


    }
}