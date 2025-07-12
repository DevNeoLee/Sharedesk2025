import { Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["field", "map", "latitude", "longitude"]

  connect() {
    console.log("Maps controller connected")
    console.log("Google object available:", typeof google !== "undefined")
    
    if (typeof google !== "undefined") {
      console.log("Google Maps API is loaded, initializing map...")
      this.initializeMap()
    } else {
      console.log("Google Maps API not loaded yet, waiting...")
      // Wait for Google Maps API to load
      this.waitForGoogleMaps()
    }
  }

  waitForGoogleMaps() {
    const checkGoogleMaps = () => {
      if (typeof google !== "undefined" && google.maps) {
        console.log("Google Maps API loaded, initializing map...")
        this.initializeMap()
      } else {
        console.log("Still waiting for Google Maps API...")
        setTimeout(checkGoogleMaps, 100)
      }
    }
    checkGoogleMaps()
  }

  initializeMap() {
    console.log("Initializing map components...")
    try {
      this.map()
      this.marker()
      this.autocomplete()
      console.log("Map initialization completed successfully")
    } catch (error) {
      console.error("Error initializing map:", error)
    }
  }

  map() {
    if(this._map == undefined) {
      console.log("Creating new map...")
      console.log("Map target element:", this.mapTarget)
      console.log("Initial coordinates:", this.latitudeTarget.value, this.longitudeTarget.value)
      
      this._map = new google.maps.Map(this.mapTarget, {
        center: new google.maps.LatLng(
          this.latitudeTarget.value || 37.7749,
          this.longitudeTarget.value || -122.4194
        ),
        zoom: 17
      })
      console.log("Map created successfully")
    }
    return this._map
  }

  marker() {
    if (this._marker == undefined) {
      console.log("Creating new marker...")
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
      console.log("Marker created at:", mapLocation)
    }
    return this._marker
  }

  autocomplete() {
    if (this._autocomplete == undefined) {
      console.log("Creating autocomplete...")
      console.log("Field target element:", this.fieldTarget)
      console.log("Field target value:", this.fieldTarget.value)
      console.log("Field target type:", this.fieldTarget.type)
      console.log("Field target name:", this.fieldTarget.name)
      
      if (!google.maps.places) {
        console.error("Google Maps Places API not available!")
        return
      }
      
      try {
        this._autocomplete = new google.maps.places.Autocomplete(this.fieldTarget)
        console.log("Autocomplete object created:", this._autocomplete)
        
        this._autocomplete.bindTo('bounds', this.map())
        this._autocomplete.setFields(['address_components', 'geometry', 'icon', 'name'])
        
        // Add autocomplete event listener
        this._autocomplete.addListener('place_changed', this.locationChanged.bind(this))
        
        // Additional event listeners
        this.fieldTarget.addEventListener('input', (e) => {
          console.log("Input event triggered:", e.target.value)
        })
        
        this.fieldTarget.addEventListener('keydown', (e) => {
          console.log("Keydown event triggered:", e.key)
        })
        
        this.fieldTarget.addEventListener('focus', (e) => {
          console.log("Focus event triggered")
        })
        
        this.fieldTarget.addEventListener('blur', (e) => {
          console.log("Blur event triggered")
        })
        
        console.log("Autocomplete created successfully with all event listeners")
      } catch (error) {
        console.error("Error creating autocomplete:", error)
      }
    }
    return this._autocomplete
  }

  locationChanged() {
    console.log("Location changed event triggered")
    let place = this.autocomplete().getPlace()
    console.log("Selected place:", place)

    if (!place.geometry) {
      console.warn("No geometry available for place:", place.name)
      window.alert("No details available for input: '" + place.name + "'");
      return;
    }

    console.log("Place geometry:", place.geometry)
    console.log("Place location:", place.geometry.location)

    this.map().fitBounds(place.geometry.viewport)
    this.map().setCenter(place.geometry.location)
    this.marker().setPosition(place.geometry.location)
    this.marker().setVisible(true)

    this.latitudeTarget.value = place.geometry.location.lat()
    this.longitudeTarget.value = place.geometry.location.lng()
    
    console.log("Updated coordinates:", this.latitudeTarget.value, this.longitudeTarget.value)
  }

  preventSubmit(e) {
    if (e.key == "Enter") { 
      console.log("Preventing form submit on Enter key")
      e.preventDefault() 
    }
  }
}
