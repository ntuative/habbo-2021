package com.sulake.habbo.navigator.domain
{
    import com.sulake.habbo.communication.messages.outgoing.navigator.SetRoomSessionTagsMessageComposer;

    public class RoomSessionTags 
    {

        private var _tag1:String;
        private var _tag2:String;

        public function RoomSessionTags(_arg_1:String, _arg_2:String)
        {
            _tag1 = _arg_1;
            _tag2 = _arg_2;
        }

        public function getMsg():SetRoomSessionTagsMessageComposer
        {
            return (new SetRoomSessionTagsMessageComposer(_tag1, _tag2));
        }


    }
}