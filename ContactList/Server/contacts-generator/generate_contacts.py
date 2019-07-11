import sys, argparse, json
from faker import Faker

def main(argv):
   parser = argparse.ArgumentParser()
   parser.add_argument("-n", "--number",
      required=False,
      default=100,
      action='store',
      dest='count',
      help="number of contacts to generate")
   parser.add_argument("-o", "--output",
      required=False,
      action='store',
      dest='output_file',
      help="output file for saving contacts")
   results = parser.parse_args()
   contacts = []
   for _ in range(int(results.count)):
      contacts.append(generate_contact(Faker()))
   if results.output_file is not None:
      with open(results.output_file, 'w') as json_file:
         json.dump(contacts, json_file, default=str)

def generate_contact(faker):
   return {
      "avatar": faker.image_url(),
      "first_name": faker.first_name(),
      "last_name": faker.last_name(),
      "email": [
         faker.company_email(),
         faker.free_email()
      ],
      "phone": [
         faker.phone_number(),
         faker.phone_number()
      ],
      "company": faker.company(),
      "hire_date": faker.date_between(start_date="-10y", end_date="today"),
      "location": [
         generate_location(faker),
         generate_location(faker)
      ]
   }

def generate_location(faker):
   return {
      "address": faker.street_address(),
      "city": faker.city(),
      "state": faker.state(),
      "country": "USA",
      "zip_code": faker.zipcode_plus4()
   }

if __name__ == "__main__":
   main(sys.argv[1:])