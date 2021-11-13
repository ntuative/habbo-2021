package com.sulake.habbo.communication.messages.parser.talent
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class TalentTrackMessageParser implements IMessageParser 
    {

        private var _talentTrack:TalentTrack;


        public function flush():Boolean
        {
            _talentTrack = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _talentTrack = new TalentTrack();
            _talentTrack.parse(_arg_1);
            return (true);
        }

        public function getTalentTrack():TalentTrack
        {
            return (_talentTrack);
        }


    }
}