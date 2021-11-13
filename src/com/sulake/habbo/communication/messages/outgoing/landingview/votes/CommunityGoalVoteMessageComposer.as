package com.sulake.habbo.communication.messages.outgoing.landingview.votes
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class CommunityGoalVoteMessageComposer implements IMessageComposer 
    {

        private var _voteOption:int;

        public function CommunityGoalVoteMessageComposer(_arg_1:int)
        {
            this._voteOption = _arg_1;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([_voteOption]);
        }


    }
}