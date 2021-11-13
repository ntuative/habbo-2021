package com.sulake.habbo.communication.messages.parser.moderation
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class IssuePickFailedMessageParser implements IMessageParser 
    {

        private var _issues:Array;
        private var _retryEnabled:Boolean;
        private var _retryCount:int;


        public function get issues():Array
        {
            return (_issues);
        }

        public function get retryEnabled():Boolean
        {
            return (_retryEnabled);
        }

        public function get retryCount():int
        {
            return (_retryCount);
        }

        public function flush():Boolean
        {
            _issues = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_7:int;
            var _local_3:int;
            var _local_2:int;
            var _local_5:String;
            var _local_4:IssueMessageData;
            _issues = [];
            var _local_6:int = _arg_1.readInteger();
            _local_7 = 0;
            while (_local_7 < _local_6)
            {
                _local_3 = _arg_1.readInteger();
                _local_2 = _arg_1.readInteger();
                _local_5 = _arg_1.readString();
                _local_4 = new IssueMessageData(_local_3, 0, 0, 0, 0, 0, 0, 0, null, 0, null, _local_2, _local_5, null, 0, []);
                _issues.push(_local_4);
                _local_7++;
            };
            _retryEnabled = _arg_1.readBoolean();
            _retryCount = _arg_1.readInteger();
            return (true);
        }


    }
}