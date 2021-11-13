package com.sulake.habbo.communication.messages.parser.groupforums
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ForumDataMessageParser implements IMessageParser 
    {

        private var _forumData:ExtendedForumData;


        public function get forumData():ExtendedForumData
        {
            return (_forumData);
        }

        public function flush():Boolean
        {
            _forumData = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _forumData = ExtendedForumData.readFromMessage(_arg_1);
            return (true);
        }


    }
}