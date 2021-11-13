package com.sulake.habbo.room.object.visualization.furniture
{
    import com.sulake.room.object.IRoomObjectModel;

    public class FurnitureRoomBillboardVisualization extends FurnitureRoomBrandingVisualization 
    {


        override protected function getAdClickUrl(_arg_1:IRoomObjectModel):String
        {
            return (_arg_1.getString("furniture_branding_url"));
        }

        override protected function getSpriteXOffset(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            return (super.getSpriteXOffset(_arg_1, _arg_2, _arg_3) + _SafeStr_3360);
        }

        override protected function getSpriteYOffset(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            return (super.getSpriteYOffset(_arg_1, _arg_2, _arg_3) + _SafeStr_3361);
        }

        override protected function getSpriteZOffset(_arg_1:int, _arg_2:int, _arg_3:int):Number
        {
            return (super.getSpriteZOffset(_arg_1, _arg_2, _arg_3) + (_SafeStr_3362 * -1));
        }


    }
}

