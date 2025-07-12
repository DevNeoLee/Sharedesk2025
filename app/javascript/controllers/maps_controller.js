import { Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["field", "map", "latitude", "longitude"]

  connect() {
    if (typeof google !== "undefined" && google.maps) {
      this.initializeMap()
    } else {
      this.waitForGoogleMaps()
    }
  }

  waitForGoogleMaps() {
    let attempts = 0
    const maxAttempts = 50
    
    const checkGoogleMaps = () => {
      attempts++
      
      if (typeof google !== "undefined" && google.maps) {
        this.initializeMap()
      } else if (attempts >= maxAttempts) {
        console.error("Google Maps API failed to load after 5 seconds")
      } else {
        setTimeout(checkGoogleMaps, 100)
      }
    }
    checkGoogleMaps()
  }

  initializeMap() {
    try {
      this.map()
      this.marker()
      this.autocomplete()
    } catch (error) {
      console.error("Error initializing map:", error)
    }
  }

  map() {
    if(this._map == undefined) {
      this._map = new google.maps.Map(this.mapTarget, {
        center: new google.maps.LatLng(
          this.latitudeTarget.value || 37.7749,
          this.longitudeTarget.value || -122.4194
        ),
        zoom: 17
      })
    }
    return this._map
  }

  marker() {
    if (this._marker == undefined) {
      this._marker = new google.maps.Marker({
        map: this.map(),
        anchorPoint: new google.maps.Point(0,0)
      })
      let mapLocation = {
        lat: parseFloat(this.latitudeTarget.value) || 37.7749,
        lng: parseFloat(this.longitudeTarget.value) || -122.4194
      }
      this._marker.setPosition(mapLocation)
      this._marker.setVisible(true)
    }
    return this._marker
  }

  autocomplete() {
    if (this._autocomplete == undefined) {
      if (!google.maps.places) {
        return
      }
      
      try {
        this._autocomplete = new google.maps.places.Autocomplete(this.fieldTarget)
        this._autocomplete.bindTo('bounds', this.map())
        this._autocomplete.setFields(['address_components', 'geometry', 'icon', 'name'])
        this._autocomplete.addListener('place_changed', this.locationChanged.bind(this))
      } catch (error) {
        console.error("Error creating autocomplete:", error)
      }
    }
    return this._autocomplete
  }

  locationChanged() {
    let place = this.autocomplete().getPlace()

    if (!place.geometry) {
      window.alert("No details available for input: '" + place.name + "'");
      return;
    }

    this.map().fitBounds(place.geometry.viewport)
    this.map().setCenter(place.geometry.location)
    this.marker().setPosition(place.geometry.location)
    this.marker().setVisible(true)

    this.latitudeTarget.value = place.geometry.location.lat()
    this.longitudeTarget.value = place.geometry.location.lng()
  }

  preventSubmit(e) {
    if (e.key == "Enter") { 
      e.preventDefault() 
    }
  }
}
