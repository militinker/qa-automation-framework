import pandas as pd

# Sample dataset used for QA validation
data = {
    "customer_id": [101, 102, 103, 103, 105],
    "customer_name": ["John", "Sarah", None, "Michael", "Emma"],
    "email": [
        "john@example.com",
        "sarah@example.com",
        "michael@example.com",
        "michael@example.com",
        None
    ],
    "status": ["Active", "Active", "Inactive", "Active", "Active"]
}

df = pd.DataFrame(data)


def validate_null_values(dataframe):
    """Identify NULL values in required fields."""

    required_columns = [
        "customer_id",
        "customer_name",
        "email"
    ]

    return dataframe[required_columns].isnull().sum()


def validate_duplicates(dataframe):
    """Identify duplicate customer IDs."""

    return dataframe[
        dataframe.duplicated(
            subset=["customer_id"],
            keep=False
        )
    ]


def validate_status_values(dataframe):
    """Validate allowed business-rule values."""

    allowed_statuses = ["Active", "Inactive"]

    return dataframe[
        ~dataframe["status"].isin(allowed_statuses)
    ]


print("NULL VALUE VALIDATION")
print(validate_null_values(df))

print("\nDUPLICATE VALIDATION")
print(validate_duplicates(df))

print("\nBUSINESS RULE VALIDATION")
print(validate_status_values(df))
