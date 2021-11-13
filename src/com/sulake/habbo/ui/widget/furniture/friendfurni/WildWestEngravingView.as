package com.sulake.habbo.ui.widget.furniture.friendfurni
{
    import com.sulake.habbo.room.object.data.StringArrayStuffData;

    public class WildWestEngravingView extends FriendFurniEngravingView 
    {

        public function WildWestEngravingView(_arg_1:FriendFurniEngravingWidget, _arg_2:StringArrayStuffData)
        {
            super(_arg_1, _arg_2);
        }

        override protected function assetName():String
        {
            return ("wildwest_engraving_xml");
        }


    }
}