import Component from "@ember/component";
import { on } from "@ember/modifier";
import { action } from "@ember/object";
import didInsert from "@ember/render-modifiers/modifiers/did-insert";
import willDestroy from "@ember/render-modifiers/modifiers/will-destroy";
import { service } from "@ember/service";
import i18n from "discourse-common/helpers/i18n";
// import discourseComputed from "discourse-common/utils/decorators";

export default class Banner extends Component {
  @service currentUser;
  tl = null;

  @action
  async setup() {}

  get logoLocation() {
    const logo =
      this.currentUser.geo_location.country_code === "CA"
        ? [settings.theme_uploads.ca_mobile, settings.theme_uploads.ca_desktop]
        : [settings.theme_uploads.us_mobile, settings.theme_uploads.us_desktop];

    return logo;
  }

  get alt() {
    const alt =
      this.currentUser.geo_location.country_code === "CA"
        ? i18n(themePrefix("banner.ca"))
        : i18n(themePrefix("banner.us"));

    return alt;
  }

  @action
  gotoURL() {
    const url =
      this.currentUser.geo_location.country_code === "CA"
        ? settings.tagURLca
        : settings.tagURLusa;

    window.open(url, "_blank");
  }

  <template>
    <div
      class="space-banner"
      role="button"
      {{didInsert this.setup}}
      {{on "click" this.gotoURL}}
    >
		<picture>
			<img src={{this.logoLocation[0]}} alt={{this.alt}} />
		</picture>
	</div>
  </template>
}
