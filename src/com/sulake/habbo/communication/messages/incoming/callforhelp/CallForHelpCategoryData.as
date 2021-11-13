package com.sulake.habbo.communication.messages.incoming.callforhelp
{
    import com.sulake.habbo.communication.messages.incoming.moderation.INamed;
    import com.sulake.core.runtime.IDisposable;
    import __AS3__.vec.Vector;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CallForHelpCategoryData implements INamed, IDisposable 
    {

        private var _name:String;
        private var _topics:Vector.<CallForHelpTopicData>;
        private var _disposed:Boolean;

        public function CallForHelpCategoryData(_arg_1:IMessageDataWrapper)
        {
            var _local_2:int;
            super();
            _topics = new Vector.<CallForHelpTopicData>();
            _name = _arg_1.readString();
            var _local_3:int = _arg_1.readInteger();
            _local_2 = 0;
            while (_local_2 < _local_3)
            {
                _topics.push(new CallForHelpTopicData(_arg_1));
                _local_2++;
            };
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            _disposed = true;
            _topics = null;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get name():String
        {
            return (_name);
        }

        public function get topics():Vector.<CallForHelpTopicData>
        {
            return (_topics);
        }


    }
}