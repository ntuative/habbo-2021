package com.sulake.habbo.window.widgets
{
    import flash.utils.Dictionary;

    public class WidgetClasses 
    {

        public static var _SafeStr_445:Dictionary = new Dictionary();
        public static var WIDGET_TYPES:Array = [];
        private static var key:String;

        {
            _SafeStr_445["avatar_image"] = AvatarImageWidget;
            _SafeStr_445["badge_image"] = BadgeImageWidget;
            _SafeStr_445["balloon"] = BalloonWidget;
            _SafeStr_445["countdown"] = CountdownWidget;
            _SafeStr_445["hover_bitmap"] = HoverBitmapWidget;
            _SafeStr_445["illumina_border"] = IlluminaBorderWidget;
            _SafeStr_445["illumina_chat_bubble"] = IlluminaChatBubbleWidget;
            _SafeStr_445["illumina_input"] = IlluminaInputWidget;
            _SafeStr_445["progress_indicator"] = ProgressIndicatorWidget;
            _SafeStr_445["limited_item_overlay_grid"] = LimitedItemGridOverlayWidget;
            _SafeStr_445["limited_item_overlay_preview"] = LimitedItemPreviewOverlayWidget;
            _SafeStr_445["limited_item_overlay_supply"] = LimitedItemSupplyLeftOverlayWidget;
            _SafeStr_445["rarity_item_overlay_grid"] = RarityItemGridOverlayWidget;
            _SafeStr_445["rarity_item_overlay_preview"] = RarityItemPreviewOverlayWidget;
            _SafeStr_445["separator"] = SeparatorWidget;
            _SafeStr_445["updating_timestamp"] = UpdatingTimeStampWidget;
            _SafeStr_445["running_number"] = RunningNumberWidget;
            _SafeStr_445["pet_image"] = PetImageWidget;
            _SafeStr_445["furniture_image"] = FurnitureImageWidget;
            _SafeStr_445["room_previewer"] = RoomPreviewerWidget;
            _SafeStr_445["pixel_limit"] = PixelLimitWidget;
            _SafeStr_445["room_thumbnail"] = RoomThumbnailWidget;
            _SafeStr_445["room_user_count"] = RoomUserCountWidget;
            for (key in _SafeStr_445)
            {
                WIDGET_TYPES.push(key);
            };
            WIDGET_TYPES.sort();
        }


    }
}

