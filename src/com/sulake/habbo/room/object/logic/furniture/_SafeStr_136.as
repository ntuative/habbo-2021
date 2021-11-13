package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.object.data.VoteResultStuffData;
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class _SafeStr_136 extends FurnitureMultiStateLogic 
    {


        override public function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void
        {
            var _local_2:VoteResultStuffData;
            super.processUpdateMessage(_arg_1);
            var _local_3:RoomObjectDataUpdateMessage = (_arg_1 as RoomObjectDataUpdateMessage);
            if (_local_3 != null)
            {
                _local_2 = (_local_3.data as VoteResultStuffData);
                if (_local_2 != null)
                {
                    object.getModelController().setNumber("furniture_vote_majority_result", _local_2.result);
                };
            };
        }


    }
}

