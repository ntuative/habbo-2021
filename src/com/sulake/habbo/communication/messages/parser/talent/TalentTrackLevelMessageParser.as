package com.sulake.habbo.communication.messages.parser.talent
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class TalentTrackLevelMessageParser implements IMessageParser 
    {

        private var _talentTrackName:String;
        private var _level:int;
        private var _maxLevel:int;


        public function flush():Boolean
        {
            _talentTrackName = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _talentTrackName = _arg_1.readString();
            _level = _arg_1.readInteger();
            _maxLevel = _arg_1.readInteger();
            return (true);
        }

        public function get talentTrackName():String
        {
            return (_talentTrackName);
        }

        public function get level():int
        {
            return (_level);
        }

        public function get maxLevel():int
        {
            return (_maxLevel);
        }


    }
}