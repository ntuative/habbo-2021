package com.sulake.habbo.communication.messages.parser.moderation
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ModeratorInitData implements IDisposable 
    {

        private var _messageTemplates:Array;
        private var _roomMessageTemplates:Array;
        private var _issues:Array;
        private var _cfhPermission:Boolean;
        private var _chatlogsPermission:Boolean;
        private var _alertPermission:Boolean;
        private var _kickPermission:Boolean;
        private var _banPermission:Boolean;
        private var _roomAlertPermission:Boolean;
        private var _roomKickPermission:Boolean;
        private var _disposed:Boolean;

        public function ModeratorInitData(_arg_1:IMessageDataWrapper)
        {
            var _local_4:int;
            super();
            var _local_2:IssueInfoMessageParser = new IssueInfoMessageParser();
            _issues = [];
            _messageTemplates = [];
            _roomMessageTemplates = [];
            var _local_3:int = _arg_1.readInteger();
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                if (_local_2.parse(_arg_1))
                {
                    _issues.push(_local_2.issueData);
                };
                _local_4++;
            };
            _local_3 = _arg_1.readInteger();
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                _messageTemplates.push(_arg_1.readString());
                _local_4++;
            };
            _local_3 = _arg_1.readInteger();
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                _arg_1.readString();
                _local_4++;
            };
            _cfhPermission = _arg_1.readBoolean();
            _chatlogsPermission = _arg_1.readBoolean();
            _alertPermission = _arg_1.readBoolean();
            _kickPermission = _arg_1.readBoolean();
            _banPermission = _arg_1.readBoolean();
            _roomAlertPermission = _arg_1.readBoolean();
            _roomKickPermission = _arg_1.readBoolean();
            _local_3 = _arg_1.readInteger();
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                _roomMessageTemplates.push(_arg_1.readString());
                _local_4++;
            };
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            _disposed = true;
            _messageTemplates = null;
            _roomMessageTemplates = null;
            _issues = null;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get messageTemplates():Array
        {
            return (_messageTemplates);
        }

        public function get roomMessageTemplates():Array
        {
            return (_roomMessageTemplates);
        }

        public function get issues():Array
        {
            return (_issues);
        }

        public function get cfhPermission():Boolean
        {
            return (_cfhPermission);
        }

        public function get chatlogsPermission():Boolean
        {
            return (_chatlogsPermission);
        }

        public function get alertPermission():Boolean
        {
            return (_alertPermission);
        }

        public function get kickPermission():Boolean
        {
            return (_kickPermission);
        }

        public function get banPermission():Boolean
        {
            return (_banPermission);
        }

        public function get roomAlertPermission():Boolean
        {
            return (_roomAlertPermission);
        }

        public function get roomKickPermission():Boolean
        {
            return (_roomKickPermission);
        }


    }
}