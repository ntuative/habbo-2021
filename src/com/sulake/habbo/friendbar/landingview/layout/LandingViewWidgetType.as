package com.sulake.habbo.friendbar.landingview.layout
{
    import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
    import com.sulake.habbo.friendbar.landingview.widget.CommunityGoalHallOfFameWidget;
    import com.sulake.habbo.friendbar.landingview.widget.CommunityGoalPrizesWidget;
    import com.sulake.habbo.friendbar.landingview.widget.AvatarImageWidget;
    import com.sulake.habbo.friendbar.landingview.widget.CommunityGoalWidget;
    import com.sulake.habbo.friendbar.landingview.widget.CommunityGoalVsModeWidget;
    import com.sulake.habbo.friendbar.landingview.widget.CommunityGoalVsModeWidgetWithVoting;
    import com.sulake.habbo.friendbar.landingview.widget.CatalogPromoWidget;
    import com.sulake.habbo.friendbar.landingview.widget.CatalogPromoWidgetSmall;
    import com.sulake.habbo.friendbar.landingview.widget.DailyQuestWidget;
    import com.sulake.habbo.friendbar.landingview.widget.ExpiringCatalogPageWidget;
    import com.sulake.habbo.friendbar.landingview.widget.ExpiringCatalogPageSmallWidget;
    import com.sulake.habbo.friendbar.landingview.widget.NextLimitedRareCountdownWidget;
    import com.sulake.habbo.friendbar.landingview.widget.HabboModerationPromoWidget;
    import com.sulake.habbo.friendbar.landingview.widget.HabboTalentsPromoWidget;
    import com.sulake.habbo.friendbar.landingview.widget.HabboWayPromoWidget;
    import com.sulake.habbo.friendbar.landingview.widget.RoomHopperNetworkWidget;
    import com.sulake.habbo.friendbar.landingview.widget.SafetyQuizPromoWidget;
    import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
    import com.sulake.habbo.friendbar.landingview.widget.WidgetContainerWidget;
    import com.sulake.habbo.friendbar.landingview.widget.PromoArticleWidget;
    import com.sulake.habbo.friendbar.landingview.widget.BonusRarePromoWidget;
    import com.sulake.habbo.friendbar.landingview.HabboLandingView;

    public class LandingViewWidgetType 
    {

        public static const AVATARIMAGE:String = "avatarimage";
        public static const EXPIRINGCATALOGPAGE:String = "expiringcatalogpage";
        public static const _SafeStr_2318:String = "expiringcatalogpagesmall";
        public static const COMMUNITYGOAL:String = "communitygoal";
        public static const COMMUNITYGOALVS:String = "communitygoalvsmode";
        public static const COMMUNITYGOALVSVOTE:String = "communitygoalvsmodevote";
        public static const CATALOGPROMO:String = "catalogpromo";
        public static const CATALOGPROMOSMALL:String = "catalogpromosmall";
        public static const ACHIEVEMENTCOMPETITIONHALLOFFAME:String = "achievementcompetition_hall_of_fame";
        public static const ACHIEVEMENTCOMPETITIONPRIZES:String = "achievementcompetition_prizes";
        public static const DAILYQUEST:String = "dailyquest";
        public static const _SafeStr_2319:String = "nextlimitedrarecountdown";
        public static const HABBOMODERATIONPROMO:String = "habbomoderationpromo";
        public static const HABBOTALENTSPROMO:String = "habbotalentspromo";
        public static const HABBOWAYPROMO:String = "habbowaypromo";
        public static const ROOMHOPPERNETWORK:String = "roomhoppernetwork";
        public static const SAFETYQUIZPROMO:String = "safetyquizpromo";
        public static const GENERIC:String = "generic";
        public static const WIDGETCONTAINER:String = "widgetcontainer";
        public static const PROMOARTICLE:String = "promoarticle";
        public static const BONUSRARE:String = "bonusrare";


        public static function getWidgetForType(_arg_1:String, _arg_2:HabboLandingView):ILandingViewWidget
        {
            var _local_3:ILandingViewWidget;
            switch (_arg_1)
            {
                case "achievementcompetition_hall_of_fame":
                    _local_3 = new CommunityGoalHallOfFameWidget(_arg_2);
                    break;
                case "achievementcompetition_prizes":
                    _local_3 = new CommunityGoalPrizesWidget(_arg_2);
                    break;
                case "avatarimage":
                    _local_3 = new AvatarImageWidget(_arg_2);
                    break;
                case "communitygoal":
                    _local_3 = new CommunityGoalWidget(_arg_2);
                    break;
                case "communitygoalvsmode":
                    _local_3 = new CommunityGoalVsModeWidget(_arg_2);
                    break;
                case "communitygoalvsmodevote":
                    _local_3 = new CommunityGoalVsModeWidgetWithVoting(_arg_2);
                    break;
                case "catalogpromo":
                    _local_3 = new CatalogPromoWidget(_arg_2);
                    break;
                case "catalogpromosmall":
                    _local_3 = new CatalogPromoWidgetSmall(_arg_2);
                    break;
                case "dailyquest":
                    _local_3 = new DailyQuestWidget(_arg_2);
                    break;
                case "expiringcatalogpage":
                    _local_3 = new ExpiringCatalogPageWidget(_arg_2);
                    break;
                case "expiringcatalogpagesmall":
                    _local_3 = new ExpiringCatalogPageSmallWidget(_arg_2);
                    break;
                case "nextlimitedrarecountdown":
                    _local_3 = new NextLimitedRareCountdownWidget(_arg_2);
                    break;
                case "habbomoderationpromo":
                    _local_3 = new HabboModerationPromoWidget(_arg_2);
                    break;
                case "habbotalentspromo":
                    _local_3 = new HabboTalentsPromoWidget(_arg_2);
                    break;
                case "habbowaypromo":
                    _local_3 = new HabboWayPromoWidget(_arg_2);
                    break;
                case "roomhoppernetwork":
                    _local_3 = new RoomHopperNetworkWidget(_arg_2);
                    break;
                case "safetyquizpromo":
                    _local_3 = new SafetyQuizPromoWidget(_arg_2);
                    break;
                case "generic":
                    _local_3 = new GenericWidget(_arg_2);
                    break;
                case "widgetcontainer":
                    _local_3 = new WidgetContainerWidget(_arg_2);
                    break;
                case "promoarticle":
                    _local_3 = new PromoArticleWidget(_arg_2);
                    break;
                case "bonusrare":
                    _local_3 = new BonusRarePromoWidget(_arg_2);
            };
            return (_local_3);
        }


    }
}

